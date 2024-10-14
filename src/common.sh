function set_output() {
    KEY=$1
    VALUE=$2

    echo "$KEY"
    echo "$VALUE"
    {
        echo "$KEY<<EOF"
        echo "$VALUE"
        echo "EOF"
    } >> "$GITHUB_OUTPUT"
}
