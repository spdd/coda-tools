# A simple bash script bot to send status message to telegram
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}"

        CODA_PK="<YOUR_PUBLIC_KEY>"
        sync_status="Synced|Catchup|Bootstrap"
        status=`coda client status | grep -E $sync_status`
        if [ -z "$status" ]; then
            echo "Coda crashed, trying to run coda..."
            echo -e "<YOUR PASSWORD>\n" | coda daemon -discovery-port 8303
        else
            message = "Coda is ${status}!"
            echo "$message"
            # Telegram notification
            # If no need to notificate just comment line bellow
            curl -s "${tg_api}/sendMessage?chat_id=${chat_id}" \
                --data-urlencode "text=${message}"
        fi
        sleep 30
    done