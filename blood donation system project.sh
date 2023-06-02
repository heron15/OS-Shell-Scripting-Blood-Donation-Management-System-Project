#!/bin/bash

declare -a donors

insert() {
    name="$1"
    age="$2"
    bloodGroup="$3"
    number="$4"

    donors+=("$name:$age:$bloodGroup:$number")
}

display() {
    if [ ${#donors[@]} -eq 0 ]; then
	echo ""
        echo "No donor records found.\n"
	echo ""
    else
        for donor in "${donors[@]}"; do
            IFS=':' read -ra details <<< "$donor"
	    echo ""
            echo "Donor Name: ${details[0]}"
            echo "Donor Age: ${details[1]}"
            echo "Donor Blood Group: ${details[2]}"
            echo "Donor Number: ${details[3]}"
        done
    fi
}

search() {
    bloodGroup="$1"

    if [ ${#donors[@]} -eq 0 ]; then
	echo ""
        echo "No donor records found."
	echo ""
    else
        found=false
        for donor in "${donors[@]}"; do
            IFS=':' read -ra details <<< "$donor"
            if [ "${details[2]}" = "$bloodGroup" ]; then
		echo ""
                echo "Donor Name: ${details[0]}"
                echo "Donor Age: ${details[1]}"
                echo "Donor Blood Group: ${details[2]}"
                echo "Donor Number: ${details[3]}\n"
                found=true
            fi
        done

        if [ "$found" = false ]; then
	    echo ""
            echo "No donors with the blood group '$bloodGroup' found."
	    echo ""
        fi
    fi
}

while true; do
    echo ""
    echo "1. Add Donor Details."
    echo "2. Search Donor."
    echo "3. View All Donors."
    echo "4. Exit."
    echo ""

    read -p "Choose an option: " option

    case $option in
        1)
            read -p "Enter name: " name
            read -p "Enter Age: " age
            read -p "Enter Blood Group: " bloodGroup
            read -p "Enter Number: " number

            insert "$name" "$age" "$bloodGroup" "$number"
            ;;
        2)
            read -p "Enter Blood Group: " bloodGroup

            search "$bloodGroup"
            ;;
        3)
            display
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Wrong option chosen."
            ;;
    esac
done
