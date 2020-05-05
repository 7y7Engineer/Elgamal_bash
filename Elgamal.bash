#!/bin/bash
# Elgamal reference in bash
# do not use this for anything execept educational use.
# this is not a license thing. it's rather a good advice.

p=$1    # random prime. Exp: 11
g=$2    # primitive root modulo p. Exp: 2
msg=$3  # the message. Exmpl: 5

# random integer number in range 1 to n
function random_integer() { 
	n=$1
	random_num=0
	until [[ 1 -lt $random_num && $random_num -lt $n ]]; do
		random_num=$RANDOM
	done
	return $random_num
}

random_integer $p ; x=$?
let y=($g**$x)%p
# print generated key environment
echo "public key (p, g, y): ($p, $g, $y)"
echo "private key x: $x"

# show original message
echo "original msg: $msg"

random_integer $((p-1)) ; k=$?
echo "k: $k"

#encrypt message
let a=($g**$k)%$p
let b=($y**$k)*$msg ; let b%=$p

#show encrypted message
echo "encrypted message — couple (a, b): ($a, $b)"

# decrypt message m=b*(a^x)^(-1)mod p =b*a^(p-1-x)mod p 
let buf=$p-1-$x; let dercyped_msg=($a**buf)*$b; let dercyped_msg%=$p
#show decrypt message
echo "decrypt message: $dercyped_msg"