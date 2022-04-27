#!/bin/bash

input=$1
output=$2

rm -rf $output

awk 'NR==FNR{
	max_n=0
	max=0
	for(i=1;i<=NF;i=i+1){
		if($i>max){max=$i;max_n=i}
	}
	print NR"\t"16-max_n"\t"max
}' $input| sort -k2,2 -k3,3 -g >  ${output}.tmp

for i in `cut -f 2 ${output}.tmp|sort -g|uniq`
do
	awk -v i=$i '{if($2==i){print $0}}' ${output}.tmp|sort -k3,3 -gr >> $output

done

