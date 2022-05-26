#!/bin/bash
# Read and parse simple INI file 
#https://sleeplessbeastie.eu/2019/11/11/how-to-parse-ini-configuration-file-using-bash/
# Get INI section
ReadINISections(){
  local filename="$1"
  gawk '{ if ($1 ~ /^\[/) section=tolower(gensub(/\[(.+)\]/,"\\1",1,$1)); configuration[section]=1 } END {for (key in configuration) { print key} }' ${filename}
}

# Get/Set all INI sections
GetINISections(){
  local filename="$1"

  sections="$(ReadINISections $filename)"
  for section in $sections; do
    array_name="configuration_${section}"
    declare -g -A ${array_name}
  done
  eval $(gawk -F= '{ 
                    if ($1 ~ /^\[/) 
                      section=tolower(gensub(/\[(.+)\]/,"\\1",1,$1)) 
                    else if ($1 !~ /^$/ && $1 !~ /^;/) {
                      gsub(/^[ \t]+|[ \t]+$/, "", $1); 
                      gsub(/[\[\]]/, "", $1);
                      gsub(/^[ \t]+|[ \t]+$/, "", $2); 
                      if (configuration[section][$1] == "")  
                        configuration[section][$1]=$2
                      else
                        configuration[section][$1]=configuration[section][$1]" "$2} 
                    } 
                    END {
                      for (section in configuration)    
                        for (key in configuration[section]) { 
                          section_name = section
                          gsub( "-", "_", section_name)
                          print "configuration_" section_name "[\""key"\"]=\""configuration[section][key]"\";"                        
                        }
                    }' ${filename}
        )


}

if [ "$#" -eq "1" ] && [ -f "$1" ]; then
  filename="$1"
  GetINISections "$filename"

  echo -n "Configuration description: "
  if [ -n "${configuration_main["description"]}" ]; then
    echo "${configuration_main["description"]}"
  else
    echo "missing"
  fi
  echo

  for section in $(ReadINISections "${filename}"); do
    echo "[${section}]"
    for key in $(eval echo $\{'!'configuration_${section}[@]\}); do
            echo -e "  ${key} = $(eval echo $\{configuration_${section}[$key]\}) (access it using $(echo $\{configuration_${section}[$key]\}))"
    done
  done
else
  echo "missing INI file"
fi
