require 'openssl'
require 'hiera/backend/eyaml/encryptor'
require 'hiera/backend/eyaml/utils'
require 'hiera/backend/eyaml/options'
require 'aws-sdk-kms'

class Hiera
  module Backend
    module Eyaml
      module Encryptors

        class Kms < Encryptor

          self.options = {
            :key_id => {      :desc => "KMS Key ID",
                              :type => :string,
                              :default => "" },
            :aws_region => {  :desc => "AWS Region",
                              :type => :string,
                              :default => "ap-southeast-2" },
            :aws_profile => { :desc => "AWS Account",
                              :type => :string,
                              :default => "default"}
          }

          VERSION = "0.2"
          self.tag = "KMS"

          def self.encrypt plaintext
            aws_profile = self.option :aws_profile
            aws_region = self.option :aws_region
            key_id = self.option :key_id
            raise StandardError, "key_id is not defined" unless key_id

            @kms = ::Aws::KMS::Client.new(
              profile: aws_profile,
              region: aws_region,
            )

            resp = @kms.encrypt({
              key_id: key_id,
              plaintext: plaintext
            })

            resp.ciphertext_blob
          end

          def self.decrypt ciphertext
            aws_profile = self.option :aws_profile
            aws_region = self.option :aws_region

            @kms = ::Aws::KMS::Client.new(
              profile: aws_profile,
              region: aws_region,
            )

            resp = @kms.decrypt({
              ciphertext_blob: ciphertext
            })

            resp.plaintext
          end

        end

      end

    end

  end

end
