# imessage-sender

## Description
Sends an iMessage to a specified phone number. The message will be randomly selected from the messages.txt file.

## Prerequire
- You own a Macbook, which is required to run an Apple script.
- The target phone number uses iMessage.

## Setup
- Download the source code.
- Update the messages.txt with your own messages.

## Run
Run the following command in the Terminal. Replace `[path-to-the-repo]` and `[reciever-phone-number]` with your own values.
```
osascript [path-to-the-repo]/imessage.applescript [reciever-phone-number]
```
Note: Please grant the Terminal permissions to send iMessage on the first run.

## Run regularly
Use crontab to send a message every morning for example.
- Edit the crontab
```
crontab -e
```
- Insert below cronjob. Replace `[path-to-the-repo]` and `[reciever-phone-number]` with your own values.
```
0 8 * * * osascript [path-to-the-repo]/imessage.applescript [reciever-phone-number]
```
- Save and quit the crontab editing
```
:wq
```
Note: Please grant crontab permissions to send iMessage on the first run.
