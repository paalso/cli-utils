# log-speed.sh — Internet Speed Test Logger (LibreSpeed CLI)

A simple Bash script that measures internet speed using the **LibreSpeed CLI** and logs the results to a local CSV file.  
Perfect for tracking connection quality over time — especially when used with `cron`.

---

## 🔧 Installation
```bash
# Install Go (if not installed):
sudo apt install golang-go

# Clone and build LibreSpeed CLI
git clone https://github.com/librespeed/speedtest-cli.git
cd speedtest-cli
go build -o librespeed .

# Move the binary to a system-wide location
sudo mv librespeed /usr/local/bin/

# Place the script somewhere in your PATH
mkdir -p ~/scripts
cp log-speed.sh ~/scripts/
chmod +x ~/scripts/log-speed.sh
```

## 🚀 Usage
```bash
~/scripts/log-speed.sh

# Before the first run, define your current location:
echo flat_gosprom > ~/.current_location

# View the full speed test log
netlog

# View recent entries
nettail
```

## 🧪 What the script does
- Selects one of several predefined LibreSpeed servers (e.g. Poznan, Prague, Vilnius).
- Runs a speed test using the librespeed CLI tool.
- Logs results to a CSV file:
`~/.local/share/netlog/speedtest_log.csv`

## 📋 Example log entry
`flat_gosprom,74,2025-06-21T11:00:01+03:00,35,33.42,15.32`

## 🕓 Automating with cron
```bash
# Open your user crontab
crontab -e

# Add this line to run every 30 minutes:
*/30 * * * * /bin/bash /home/youruser/scripts/log-speed.sh
```
The script is self-contained and manages the log file internally — no need for output redirection.

## 📁 File Overview
| File / Path                                          | Purpose                                         |
|------------------------------------------------------|-------------------------------------------------|
| `log-speed.sh`                                       | Main script                                     |
| `~/.current_location`                                | Stores your current label (e.g. flat name)      |
| `~/.local/share/netlog/speedtest_log.csv`            | Log file with all measurements                  |

## ⚙️ Dependencies
- [LibreSpeed CLI](https://github.com/librespeed/speedtest-cli)
- bash, awk, date, script (util-linux package)

## ⚙️ Useful Aliases

To make working with logs more convenient, you can add the following aliases to your `~/.bashrc` or `~/.bash_aliases`:

```bash
# Net logging
alias here-london='echo flat_london > ~/.current_location; export MY_PLACE=$(cat ~/.current_location 2>/dev/null)'
alias here-toronto='echo office_toronto > ~/.current_location; export MY_PLACE=$(cat ~/.current_location 2>/dev/null)'
alias here-milan='echo casa_napoli > ~/.current_location; export MY_PLACE=$(cat ~/.current_location 2>/dev/null)'

alias whereami='cat ~/.current_location'

alias netlog='cat -n ~/.local/share/netlog/speedtest_log.csv'
alias nettail='(head -n1 ~/.local/share/netlog/speedtest_log.csv && tail -n 10 ~/.local/share/netlog/speedtest_log.csv)'
```
After editing .bashrc, apply the changes with `source ~/.bashrc`

Now you can quickly:
- Set your current location: `here-milan`, `here-toronto`, etc.
- Check which location is currently set: `whereami`


## 📊 Data Analysis in Jupyter / Colab

You can analyze the collected data in **Jupyter Notebook** or **Google Colab** using pandas and seaborn:

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load and parse timestamps
df = pd.read_csv("~/.local/share/netlog/speedtest_log.csv", parse_dates=["timestamp"])

# Optional time features
df["hour"] = df.timestamp.dt.hour
df["weekday"] = df.timestamp.dt.weekday + 1  # 1 = Monday, 7 = Sunday

# Average download/upload per location
print(df.groupby("location")[["download_mbps", "upload_mbps"]].mean())

# Visualize download speed over time

```

📊 What’s next?
This tool can be extended with:
- Python scripts for plotting trends (e.g. speedstat)
- HTML dashboards for visual browsing
- Alerts or notifications for speed drops
