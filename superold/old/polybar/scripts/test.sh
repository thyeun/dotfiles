#!/usr/bin/env bash
delay=0.2
fixed=0
l=0; l2=0; w2=0
while getopts 'fw:d:h' o; do

case $o in
	d) delay="$OPTARG" ;;
	f) fixed=1 ;;
	w) w="$(( OPTARG ))" ;;
	h) nr=1 ;&
	*) cat >&2 << EOF
Usage: $0 [ -h | [ [opts] [text ...] ]

Prints [text ...] as a scrolling marquee

Options:
	-f     fix width: do not change on SIGWINCH
	-w n   set width: do not detect (implies -f)
	-d n   set delay: see documentation on Bash's \`sleep\`
	-h     see this help
EOF
	exit $(( 1 - nr ))
	;;
esac

done
shift "$(( OPTIND - 1 ))"
pre="i love u"

if (( w == 0 )); then
	winch_handler(){
		w="$(tput cols)"
		s="$(printf "%${w}s" "$pre")"
	}
	winch_handler
	(( fixed != 1 )) && trap "winch_handler" SIGWINCH
else
	s="$(printf "%${w}s" "$pre")"
fi

while sleep "$delay"; do
	printf '%s\r' "${s:$l:$w}${s:$l2:$w2}"
	(( l = (l + 1) % ${#s} ))
	(( l2 = (l - ${#s}) > 0 ? (l - ${#s}) : 0 ))
	(( w2 = (l + w - ${#s}) > 0 ? (l + w - ${#s}) : 0 ))
done

