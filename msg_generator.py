import os
import git
import requests
import re
import google.generativeai as genai

def get_git_diff():
    repo = git.Repo(os.getcwd())
    diff = repo.git.diff()  
    if not diff.strip():
        return "No changes detected."
    changes_summary = []
    diff_lines = diff.splitlines()
    current_file = None

    for line in diff_lines:
        if line.startswith('diff --git'):
            current_file = line.split(' ')[-1]
            changes_summary.append(f"File: {current_file}")
        elif line.startswith('@@'):
            match = re.search(r'\+(\d+)', line)
            if match:
                line_num = match.group(1)
                changes_summary.append(f" - Line {line_num}:")
        elif line.startswith('+') and not line.startswith('+++'):
            changes_summary.append(f"   Added: {line[1:].strip()}")
        elif line.startswith('-') and not line.startswith('---'):
            changes_summary.append(f"   Removed: {line[1:].strip()}")

    return "\n".join(changes_summary)

def gen_com_msg(changes_summary):
    
    genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
    prompt = f"""
    Generate a commit message for the following git diff.
    {changes_summary}.\n\n
    Give only the commit command. No explanations.
    """
    
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(prompt)
    res = response.text
    print("\n\n")
    print("output: ", res, end = "\n\n")
    if 'git commit -m' in res:
        commit_message_match = re.search(r'git commit -m\s+"(.*)"', res)
        if commit_message_match:
            return commit_message_match.group(1) 
        else:
            return "Auto-generated commit message."
    else:
        return res.strip()

if __name__ == "__main__":
    changes_summary = get_git_diff()
    if changes_summary != "No changes detected.":
        commit_msg = gen_com_msg(changes_summary)
        print(commit_msg)
    else:
        print("No changes to commit.")