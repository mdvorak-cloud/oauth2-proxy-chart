out="/etc/oauth2-proxy/oauth2-proxy.cfg"

for f in /source/config/* ; do
  if [ "$(basename "$f")" != "__authenticated_emails" ]; then
    echo "$(basename "$f") = $(cat "$f")" >> "$out"
  else
    # NOTE hack-ish way to support inline authenticated email list in config
    cat "$f" > /etc/oauth2-proxy/authenticated-emails.txt
    echo 'authenticated_emails_file = "/etc/oauth2-proxy/authenticated-emails.txt"' >> "$out"
  fi
done

for f in /source/secret/* ; do
  # quote values as strings
  echo "$(basename "$f") = \"$(cat "$f")\"" >> "$out"
done

# TODO debug
echo "$out"
cat "$out"
echo "---"