# A simple bash script bot to send status message to telegram
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}"

        CODA_PK="YOUR_PUBLIC_KEY"
        sync_status="Synced|Catchup|Bootstrap"
        status=`coda client status | grep -E $sync_status`
        password="<YOUR WALLET PASSWORD>"
        if [ -z "$status" ]; then
            echo "Coda crashed, trying to run coda..."
            echo -e "${password}\n" | coda daemon -discovery-port 8303 \
                            -peer /dns4/seed-one.genesis.o1test.net/tcp/10002/ipfs/12D3KooWP7fTKbyiUcYJGajQDpCFo2rDexgTHFJTxCH8jvcL1eAH \
                            -peer /dns4/seed-two.genesis.o1test.net/tcp/10002/ipfs/12D3KooWL9ywbiXNfMBqnUKHSB1Q1BaHFNUzppu6JLMVn9TTPFSA \
                            -propose-key ~/keys/my-wallet \
                            -run-snark-worker $CODA_PK \
                            -snark-worker-fee 1
        else
            message="Coda ${status}!"
            echo "${message}"
            # Telegram notification
            # If no need to notificate just comment line bellow
            curl -s "${tg_api}/sendMessage?chat_id=${chat_id}" --data-urlencode "text=${message}"
        fi
        sleep 30
done
