Shell Transcript
================

Live-publish your commands and their output from a `bash` shell to GitHub Pages.

The idea for this project was specifically for instructors teaching the Unix Shell and Git lessons in [Software Carpentry](https://software-carpentry.org) workshops. Learners and helpers can review your commands even if they've already moved off the screen.


Setup
-----

Before you begin:
* You'll need `gawk` (GNU awk) and `git` installed.
* On Ubuntu/Debian, the default awk is mawk, so you'll need to install gawk.
`sudo apt-get install gawk`
* On Mac, you'll need to install gawk and a GNU version of sed. You can do this with [Homebrew](https://brew.sh/) (gawk, gnu-sed), [MacPorts](https://www.macports.org/) (gawk, gsed), or [Rudix](http://rudix.org/) (gawk, sed).

Download the `setup_ssh_key.sh` script and create an ssh key for github (or you can do this manually if you prefer).
```bash
$ wget https://raw.githubusercontent.com/evanlinde/shell-transcript/master/setup_ssh_key.sh
$ bash setup_ssh_key.sh
```

Clone this repository to your own github account, then use GitHub's [import tool](https://help.github.com/articles/importing-a-repository-with-github-importer/) to make a copy for your teaching session. I recommend naming it shell-*date* or git-*date* (e.g. shell-2017-03-20), depending on what lesson you're teaching.

[Enable github pages](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/#enabling-github-pages-to-publish-your-site-from-master-or-gh-pages) on the master branch in the repository settings.

[Add the ssh key](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/) you generated to your github account (use the contents of `~/.ssh/github.key.pub`).

Clone your repository to your local system (where you'll be teaching from).
```bash
$ cd ~
$ git clone git@github.com:your_github_username/your_repo_name.git
```


Run
---

Start transcribing your terminal:
```bash
$ bash ~/your_repo_name/start_transcript.sh
```
Your prompt will be set to "$ " in the current terminal (Linux) or in a new terminal (git bash, Cygwin) and all commands you enter and their output will be recorded. A new terminal window will open and start the `auto_push.sh` script to push the transcripts to github. The transcripts will be accessible at https://*your_github_username*.github.io/*your_repo_name*.

Three files will be created:
* `commands.txt` -- command history with no output
* `full_terminal.script` -- full output from the `script` command (commands and output) including ANSI escape sequences (created on Linux and Mac)
* `full_terminal.d` -- directory with sequentially numbered files of the log output from `mintty.exe` (created on Windows with git bash or Cygwin, equivalent to the output from `script`)
* `full_terminal.html` -- output from `script` or `mintty.exe` converted to html
The provided `index.html` uses jquery to include `full_terminal.html` and `commands.txt`.


Cleanup
-------

You'll want to do these steps when you're finished teaching:
1. End the script recording in your teaching terminal (hit Ctrl-D or type "exit").
2. Kill the `auto_push.sh` script (hit Ctrl-C in the `xterm` window or just close the `xterm` window).
3. Delete the ssh key from your github profile. (This is **very** important if you're teaching from a shared instructor station or any system that other people control or access since the key will allow pushes to your github account. You can skip this if you're using your own laptop.)
4. Delete the github ssh key from `~/.ssh` and undo changes to `~/.ssh/config`.

