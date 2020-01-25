![Coda Logo](https://cdn.codaprotocol.com/v4/static/img/coda-logo.png)

A simple bash script that keep coda always running and send status message to telegram bot

# Prerequisites
sudo apt install curl -y

# How to create telegram bot?
1. Find in Telegram @BotFather 
2. Start conversation /start
3. Enter /newbot
4. Get YOUR_BOT_TOKEN

# How to get telegram bot chat id?
1. Start conversation with your new bot
2. Send a dummy message to the bot.
3. Go to following url https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
4. Find for "chat":{"id":<YOUR_BOT_CHAT_ID>...
