#    Install fantom
    sudo apt update
    sudo apt install screen -y
    screen -S fantom
    source <(curl -s https://raw.githubusercontent.com/ERNcrypto/fantom/main/install.sh)
#    Логи 
    sudo systemctl status fantom
    sudo journalctl -u fantom -f
#    Проверка синхронизации
    curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "eth_syncing", "params":[]}' localhost:18545
#Если узел успешно синхронизирован, в выходных данных, приведенных выше, будет выведен {"jsonrpc":"2.0","id":1,"result":false}
