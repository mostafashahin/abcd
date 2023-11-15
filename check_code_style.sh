#!/usr/bin/env bash

# Check argument was provided
if [[ $# != 1 ]]
then
    echo "Usage: $0 naming-scheme" >&2
    exit 1
fi

# Get naming scheme based on quick observations
naming_scheme_arg="$1"
case "$naming_scheme_arg" in
    sc)
        pylint_naming_scheme="snake_case"
        ;;
    cc)
        pylint_naming_scheme="camelCase"
        ;;
    pc)
        pylint_naming_scheme="PascalCase"
        ;;
    *)
        echo "Naming scheme argument must be either:" >&2
        echo "- sc (snake case)" >&2
        echo "- cc (camel case)" >&2
        echo "- pc (Pascal case)" >&2
        exit 1
        ;;
esac

# Check Pylint is available
if ! python3 -c "import pylint" &> /dev/null
then
    echo "Pylint not installed in current environment" >&2
    echo "Run 'pip install pylint' (with '--break-system-packages' on Ed) to install" \
         "it" >&2
    exit 1
fi

# Run Pylint, keeping in mind naming scheme
python3 -m pylint --recursive y . --argument-naming-style="$pylint_naming_scheme" \
        --attr-naming-style="$pylint_naming_scheme" \
        --function-naming-style="$pylint_naming_scheme" \
        --method-naming-style="$pylint_naming_scheme" \
        --variable-naming-style="$pylint_naming_scheme"

