# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Git
RUN apt-get update && apt-get install -y git

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set up Git configuration
RUN git config --global user.name "Apoorv" \
    && git config --global user.email "apoorv.gupta65@gmail.com"

# Make sure the script is executable 
RUN chmod +x git-auto.sh

# Command to run your bat file
CMD ["./git-auto.sh"]
