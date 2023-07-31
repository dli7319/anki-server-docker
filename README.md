# docker-anki-server
Dockerfile which runs [Anki's built-in Self-Hosted Sync Server](https://docs.ankiweb.net/sync-server.html).

## Usage
Run this in Docker or Kubernetes with users passed in as environment variables.
```bash
docker run -it --rm \
  -e SYNC_USER1=myusername:mypasswd -p 80:8080 \
  ghcr.io/dli7319/docker-anki-server:main
```
For persistence, mount a volume to `/home/anki/.syncserver/`

Note that Anki does not provide a web interface.

Example Kubernetes deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: anki
  labels:
    app: anki
spec:
  replicas: 1
  selector:
    matchLabels:
      pod-label: anki-pod
  template:
    metadata:
      labels:
        pod-label: anki-pod
    spec:
      containers:
        - name: anki
          image: ghcr.io/dli7319/docker-anki-server:main
          imagePullPolicy: Always
          envFrom:
            - secretRef:
                name: anki-secret
          volumeMounts:
            - name: anki-storage
              mountPath: /home/anki/.syncserver
          ports:
            - containerPort: 8080
      volumes:
        - name: anki-storage
          persistentVolumeClaim:
            claimName: anki-pvc
```
