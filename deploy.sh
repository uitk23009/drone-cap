# avoid The authenticity of host 'hostname' can't be established error
mv /cap/ssh_config /root/.ssh/config

# show current execute command and add new line
exen() { echo -e "${@/eval /}\n" ; "$@" ; }

# set ssh key
echo -e "Set SSH Key\n"

temp=(${CAP_PRIVATE_KEY// / })

echo "${temp[0]} ${temp[1]} ${temp[2]} ${temp[3]}" > /root/.ssh/cap_deploy

total_len=${#temp[@]}
secret_len=$((total_len-8))

for (( i=0; i<${secret_len}; i++ )); do
    echo "${temp[$((i+4))]}" >> /root/.ssh/cap_deploy
done

echo "${temp[$((total_len-4))]} ${temp[$((total_len-3))]} ${temp[$((total_len-2))]} ${temp[$((total_len-1))]}" >> /root/.ssh/cap_deploy

cat /root/.ssh/cap_deploy

chmod 0600 /root/.ssh/cap_deploy

# add ssh key
echo -e "Add SSH Key\n"
eval `ssh-agent -s`
ssh-add /root/.ssh/cap_deploy


IFS=',' read -r -a CMDS <<< "${PLUGIN_CAP_CMD}"
for CMD in "${CMDS[@]}"; do
   exen eval "$CMD"
done
