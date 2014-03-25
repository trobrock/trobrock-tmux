#!/usr/bin/env awk

/Pages free/        { gsub(/\./, "", $3); total += $3; }
/Pages active/      { gsub(/\./, "", $3); total += $3; used += $3 }
/Pages inactive/    { gsub(/\./, "", $3); total += $3; used += $3 }
/Pages speculative/ { gsub(/\./, "", $3); total += $3; used += $3 }
/Pages wired/       { gsub(/\./, "", $4); total += $4; used += $4 }
END   { print int((used / total) * 100 + 0.5) }
