# A simple bash script bot to send status message to telegram
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}"

        CODA_PK="YOUR_PUBLIC_KEY"
        sync_status="Synced|Catchup|Bootstrap"
        status=`coda client status | grep -E ${sync_status}`
        password="<YOUR WALLET PASSWORD>"
        if ! pgrep -x "coda" > /dev/null 
        then
            crash_msg="Coda crashed, trying to run coda..."
            echo $crash_msg
            curl -s "${tg_api}" --data-urlencode "text=${crash_msg}"
            echo -e "${password}\n" | coda daemon -discovery-port 8303 \
                            -peer /dns4/seed-one.genesis.o1test.net/tcp/10002/ipfs/12D3KooWP7fTKbyiUcYJGajQDpCFo2rDexgTHFJTxCH8jvcL1eAH \
                            -peer /dns4/seed-two.genesis.o1test.net/tcp/10002/ipfs/12D3KooWL9ywbiXNfMBqnUKHSB1Q1BaHFNUzppu6JLMVn9TTPFSA \
                            -propose-key ~/keys/my-wallet \
                            -run-snark-worker $CODA_PK \
                            -snark-worker-fee 1
            sleep 180
        else
            status_msg="Coda ${status}!"
            echo "${status_msg}"
            # Telegram notification
            # If no need to notificate just comment line bellow
            curl -s "${tg_api}" --data-urlencode "text=${status_msg}"
        fi
        sleep 30
done
