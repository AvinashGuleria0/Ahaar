# Aahar Reboot Guide (USB Tethering + Physical Phone)

This guide is for your setup:
- Internet + local network via USB tethering from Infinix phone
- Same phone used to run Flutter app and scan food

---

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

## 2. Update Flutter API URL (if IP changed)

Open `lib/main.dart` and set:

```dart
final String apiUrl = "http://<YOUR_USB_IP>:8000/api/v1/analyze/vision";
```

Example:

```dart
final String apiUrl = "http://10.85.238.59:8000/api/v1/analyze/vision";
```

Quick check for stale IP:

```bash
rg -n "apiUrl\s*=\s*\"http://" lib/main.dart
```

---

## 3. Start Backend (FastAPI)

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

Open a new terminal at project root:

```bash
flutter clean
flutter pub get
flutter run
```

If app was already running, do full restart:
- Press `q` to quit old run
- Start `flutter run` again

---

## 5. Verify Everything Before Scanning

### Backend reachable from laptop

```bash
curl -I http://<YOUR_USB_IP>:8000/docs
```

Should return `200 OK`.

### Flutter is using correct URL

In `flutter run` logs, on scan button tap you should see:

```text
I/flutter: 📡 Sending request to: http://<YOUR_USB_IP>:8000/api/v1/analyze/vision
```

If it shows old IP (like `.127`), app is stale. Quit and run again.

---

## 6. Common Issues and Fixes

### `No route to host`
- Wrong IP in `apiUrl`
- USB tethering reconnected and IP changed
- Backend not running on `0.0.0.0`

### `Address already in use`
- Another server is already bound to port 8000
- Run `fuser -k 8000/tcp` and restart backend

### Groq model errors (decommissioned)
- Use currently available model configured in backend:
	`meta-llama/llama-4-scout-17b-16e-instruct`

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
flutter run
```

When USB reconnects, re-check IP and update `lib/main.dart` before running.
