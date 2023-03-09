
#Updates et installation
apt-get update && apt-get install libpq5 -y

# Créer un dossier temporaire pour stocker les bibliothèques
mkdir -p temp_libs

# Liste de noms de fichiers de bibliothèques que vous voulez copier
libs=(
    "libpq.so*" 
    "libgssapi_krb5.so*"
    "libldap_r-2.4.so*"
    "libkrb5.so*"
    "libk5crypto.so*"
    "libkrb5support.so*"
    "liblber-2.4.so*"
    "libsasl2.so*"
    "libgnutls.so*"
    "libp11-kit.so*"
    "libidn2.so*"
    "libunistring.so*"
    "libtasn1.so*"
    "libnettle.so*"
    "libhogweed.so*"
    "libgmp.so*"
    "libffi.so*"
    "libcom_err.so*"
    "libkeyutils.so*"
)


# Boucle sur la liste de noms de fichiers de bibliothèques pour les copier
for lib in "${libs[@]}"
do
  # Utilise la commande find pour chercher les fichiers correspondants
  # et copier les fichiers dans le dossier temporaire tout en conservant toute l'architecture des dossiers
  find /usr/lib -name "$lib" -exec cp --parents {} ./temp_libs \;
done

