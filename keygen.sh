#!/bin/bash
echo "Generating key..."
ssh-keygen -t dsa
echo "copying pub key to authorized_keys"
cp ~/.ssh/id_dsa.pub ~/.ssh/authorized_keys
echo "Done!"
