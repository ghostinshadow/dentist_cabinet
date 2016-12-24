require "openssl"

class Decryptor
  attr_accessor :filename, :filedata, :routine
  attr_writer :pass

  def initialize(pass, filename, routine = :CBC)
    @pass = pass
    @filename = filename
    @routine = routine
    load_file
  end

  def decrypt
  	cipher = OpenSSL::Cipher::AES256.new(:CBC)
  	cipher.decrypt
  	cipher.key = @pass
  	cipher.update(@filedata)
  end

  private

  def load_file
  	@filedata = File.open(@filename, "r").read

    rescue
  	  @filedata = "Couldn't read data"
  end

  def pass
  	self.pass
  end

end