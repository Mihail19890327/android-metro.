import os
from pathlib import Path
import subprocess

USER = "Mihail19890327"
REPO = "android-metro"
TOKEN_FILE = Path.home() / ".gh_token"


def ensure_token():
    if not TOKEN_FILE.exists():
        token = input("Вставь сюда свой GitHub токен (ghp_...): ").strip()
        TOKEN_FILE.write_text(token)
    return TOKEN_FILE.read_text().strip()


def ensure_git_remote(token):
    url = f"https://{USER}:{token}@github.com/{USER}/{REPO}.git"
    if not Path(".git").exists():
        subprocess.run(["git", "init"], check=True)
        subprocess.run(["git", "branch", "-M", "main"], check=True)
        subprocess.run(["git", "remote", "add", "origin", url], check=True)
    else:
        subprocess.run(["git", "remote", "set-url", "origin", url], check=True)


def git_push(msg="update from metro_bridge"):
    subprocess.run(["git", "add", "."], check=True)
    subprocess.run(["git", "commit", "-m", msg], check=True)
    subprocess.run(["git", "push", "-u", "origin", "main"], check=True)


if __name__ == "__main__":
    token = ensure_token()
    ensure_git_remote(token)
    print("Мост настроен. Дальше схема такая:")
    print("1) Я даю тебе файлы (путь + текст).")
    print("2) Ты создаёшь/обновляешь их через nano.")
    print("3) Когда нужно отправить всё на GitHub, вводишь:")
    print("   python metro_bridge.py push")
