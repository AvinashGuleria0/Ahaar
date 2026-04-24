# Aahar Reboot Guide (USB Tethering + Physical Phone)

## 1. Connect USB Tethering First

1. Connect phone to laptop with USB.
2. On phone, enable USB tethering.
3. Confirm Linux sees a USB network interface (usually `enp...` or `rndis...`).

Check current IPv4 addresses:

```bash
ip -4 addr show | awk '/inet /{print $2, $NF}'
```

Pick the IP on USB interface, for example:
- `10.85.238.59/24 enp6s0f4u2`

Your backend host IP is `10.85.238.59` (without `/24`).

---

## 2. Note Your Backend API URL

You no longer need to edit code to set the API URL!

The URL base will be:
`http://<YOUR_USB_IP>:8000`

Example:
`http://10.85.238.60:8000`

You will pass this directly when starting the Flutter app.

---

## 3. Start Backend (FastAPI)

Ensure Ollama is running in the background (`systemctl start ollama` or via terminal) since the backend uses a local Ollama model (`gemma4:e2b`).

From project root:

```bash
cd backend
source venv/bin/activate
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Important:
- Use `0.0.0.0` so phone can reach laptop backend.
- If you get `Address already in use`, stop old server and rerun:

```bash
fuser -k 8000/tcp
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

---

## 4. Start Flutter App (Physical Device)

Open a new terminal at project root and pass your USB IP to the app:

```bash
flutter clean
flutter pub get
flutter run --dart-define=API_URL="http://<YOUR_USB_IP>:8000"
```

If app was already running, do full restart:
- Press `q` to quit old run
- Restart with the `flutter run --dart-define...` command

---

## 5. Verify Everything Before Scanning

### Backend reachable from laptop

```bash
curl -I http://<YOUR_USB_IP>:8000/docs
```

Should return `200 OK`.

### Flutter is using correct URL

In `flutter run` logs, on scan button tap you should see requests going to your specific IP.

If it shows old IP (like `127.0.0.1`), app is stale. Quit and run again with the correct `--dart-define`.

---

## 6. Common Issues and Fixes

### `No route to host`
- Wrong IP passed to `--dart-define`
- USB tethering reconnected and IP changed
- Backend not running on `0.0.0.0`

### `Address already in use`
- Another server is already bound to port 8000
- Run `fuser -k 8000/tcp` and restart backend

### Model errors
- Ensure Ollama is running locally and has the required model (`gemma4:e2b`).

### Long startup time
- First backend start loads embedding model (`all-MiniLM-L6-v2`), this is normal

---

## 7. Daily Quick Start (Copy/Paste)

Terminal 1 (Backend):

```bash
cd /home/avinasho/coding/projects/aahar/backend
source venv/bin/activate
fuser -k 8000/tcp
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Terminal 2 (Flutter):

```bash
cd /home/avinasho/coding/projects/aahar
flutter pub get
flutter run --dart-define=API_URL="http://<YOUR_USB_IP>:8000"
```

When USB reconnects, re-check IP and run with the updated IP in `--dart-define`.
