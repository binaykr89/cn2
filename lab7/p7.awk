BEGIN {
cbr_sz=0;
}
{
if($5=="cbr" && $1=="r" && $4=="3")
cbr_sz+=$6
}
END {
print $2,(cbr_sz*8/(1000000))
}
