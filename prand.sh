#!/bin/sh

# Password Generater with Base58
# required upper and lower case letters, numbers
# length 4 or more
# ex.) $ prand.sh 16

# !環境によっては動作しない(mac, odコマンド)

# input check
pw_length=12  # default length
if [[ -nz "$1" && "$1" > 3 ]]; then
	pw_length="$1"
fi

base58=(1 2 3 4 5 6 7 8 9 A B C D E F G H J K L M N P Q R S T U V W X Y Z a b c d e f g h i j k m n o p q r s t u v w x y z)
base58m20=(1 2 3 4 5 6 7 8 9 A B C D E F G H J K L M N P Q R S T U V W X Y Z a b c d e f g h i j k m n o p q r s t u v w x y z \! \# \$ \% \& \( \) \* \+ \- \/ \< \= \> \? \@ \[ \] \{ \})



while : ;do
	str=$(od -vA n --width=4 -t u4 -N `expr $pw_length \* 4` </dev/urandom | awk '{ print $1 % 58 }')
	ary=(`echo $str`)

	# initalize flag
	flag_num=0
	flag_upp=0
	flag_low=0
	passwords=()
	i=0
	for i in ${ary[@]} ; do
		case ${base58[$i]} in
			[1-9]) flag_num=1 ;;
			[A-Z]) flag_upp=1 ;;
			[a-z]) flag_low=1 ;;
			*) echo "error." ;;
		esac
		passwords+=(`echo ${base58[$i]}`)
	done
	if [ $(( flag_num * flag_upp * flag_low )) -eq 1 ] ;then
		break
	fi
done
echo ${passwords[@]} | tr -d " "
