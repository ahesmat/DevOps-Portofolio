# SSH Git Authentication Setup – Automation Script

A Bash utility that automates switching a Git repository from HTTPS to SSH authentication. Useful in environments where interactive credential prompts aren't practical — CI/CD pipelines, shared dev servers, or any setup where you want passwordless Git operations.

---

## 🔧 What It Does

1. Extracts the remote repository URL and username from the existing Git config
2. Generates an `ed25519` SSH key pair
3. Displays the public key and prompts you to add it to GitHub
4. Switches the remote URL from HTTPS to SSH format
5. Loads the key into `ssh-agent` and verifies the GitHub connection

---

## 🚀 Usage

Run from inside your local Git repository:

```bash
./ssh-connect.sh
```

The script will prompt for your email address (used as the SSH key label), then guide you through the rest of the process.

After the script completes, run the exported environment variable it prints — this ensures your current shell session uses the running `ssh-agent`:

```bash
export SSH_AUTH_SOCK=<value printed by script>
```

---

## 💡 Why SSH Over HTTPS

- No credential prompts on every push/pull
- Works in automated pipelines without storing passwords
- `ed25519` keys are smaller and more secure than RSA
- Required in environments where HTTPS is blocked or credential helpers aren't available

---

## 📦 Prerequisites

- Git installed and configured
- SSH client (`ssh`, `ssh-keygen`, `ssh-agent`) available
- GitHub account with access to the target repository

---

## ⚠️ Notes

- The generated key is stored temporarily in `~/tmp/` — move it to `~/.ssh/` for permanent use
- Each repository gets its own key by design — avoids key reuse across projects
- The script is non-destructive: it does not modify any existing SSH keys
