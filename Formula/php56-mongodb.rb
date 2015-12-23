require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.1.tgz"
  sha256 "0899b00435edf143ddc0ededd8027013c86bf59214d63ae1f3c7be0eaae11ceb"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "deea428f9f7c8a799bdb4b8b312eb1eee7790ec9b11af39e0f4be1a21f351b34" => :el_capitan
    sha256 "2eaa5c575bfe3963a3cdabf0fdaaac03a0d240c54413895274d79855bf83456a" => :yosemite
    sha256 "bda06f208d486ef2337d586a1f143283c7c8a359aa43af33a49fb43b54967647" => :mavericks
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
