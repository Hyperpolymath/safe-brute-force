# safe-brute-force
Too often a brute force attack leaves you with millions of pages of verbose output for you to sort through to find the results of a given attempt. SafeBruteForce pauses large brute force search output every 25 attempts and asks you to confirm you want to continue before processing the next set of permutations

🔒 SafeBruteForce 🔒
Banner

A brute-force utility that prioritizes user safety and system preservation.

🔍 Why?
Traditional brute-force tools are reckless - they flood systems with requests, risk account lockouts, and leave verbose trails.
This project redefines brute-forcing as a controlled, pausable process that respects system limits while maintaining effectiveness.

📦 What You'll Find Here
🛑 Pause Mechanism: Automatic pauses every 25 attempts with user confirmation
📂 LFE/Erlang Core: A stateful, concurrent brute-force engine
🔍 Pattern Generators: Customizable permutation strategies
📊 Result Aggregation: Clean output filtering with success/failure tracking
🔄 Resume Capability: Checkpoint/restart functionality
🚀 Getting Started
Prerequisites
Erlang/OTP (v26+)
LFE (Lisp Flavored Erlang)
Rebar3 (build tool)
Quickstart
Bash

# Clone and compile
git clone https://github.com/your-username/safe-brute-force.git
cd safe-brute-force
rebar3 compile

# Run with sample config
rebar3 run -s sbf.main -a '[]'

# For custom brute-force:
# 1. Modify src/sbf.lfe with your target system
# 2. Adjust permutation strategies
# 3. Run again
🔧 Contributing
We need contributors who:

Understand the ethical implications of brute-forcing
Can write clean, concurrent Erlang/LFE code
Appreciate the value of user-controlled automation
To contribute:

Fork the repo
Add new permutation strategies or safety features
Update the pause/resume logic
Submit a pull request with a 🛡️ "Safety First" label
📜 License
MIT License - because security tools should be freely improvable.

⚠️ Disclaimer
This project contains powerful brute-force capabilities.
Improper use may result in:

Temporary system suspensions
Ethical dilemmas
Unexpected discoveries about your own password security
Use only against systems you own or have explicit permission to test.
