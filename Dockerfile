FROM public.ecr.aws/docker/library/python:3.10

# Create a user anki with group 1000
RUN groupadd -r anki -g 1000 && useradd -u 1000 -r -g anki -m -d /home/anki -s /sbin/nologin -c "Docker image user" anki

# Switch to user anki
USER anki

# Install Anki
RUN pip install anki

# Port 8080
EXPOSE 8080

# Run anki.syncserver
CMD ["python", "-m", "anki.syncserver"]