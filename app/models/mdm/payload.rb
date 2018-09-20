class Mdm::Payload < ActiveRecord::Base
  extend ActiveSupport::Autoload

  include Metasploit::Model::Search

  #
  # Associations
  #

  # {Mdm::Workspace} in which this payload was created.
  belongs_to :workspace,
             class_name: 'Mdm::Workspace',
             inverse_of: :payloads


  #
  # Attributes
  #

  # @!attribute [rw] name
  #   The name of this payload.
  #
  #   @return [String]

  # @!attribute [rw] uuid
  #   A unique identifier for this payload. The UUID is encoded to include specific information.
  #   See lib/msf/core/payload/uuid.rb in the https://github.com/rapid7/metasploit-framework repo.
  #
  #   @return [String]

  # @!attribute [rw] registered
  #   true if a session has been established using this payload, false otherwise.
  #
  #   @return [Bool]

  # @!attribute [rw] timestamp
  #   The Unix format timestamp when this payload was created.
  #
  #   @return [String]

  # @!attribute [rw] arch
  #   The architecture this payload supports.
  #   Valid values are located at lib/msf/core/payload/uuid.rb in the https://github.com/rapid7/metasploit-framework repo.
  #
  #   @return [String]

  # @!attribute [rw] platform
  #   The platform this payload supports.
  #   Valid values are located at lib/msf/core/payload/uuid.rb in the https://github.com/rapid7/metasploit-framework repo.
  #
  #   @return [String]

  # @!attribute [rw] urls
  #   The unique, encoded urls used to host this payload. Only applicable for http(s) payloads
  #
  #   @return [String]

  # @!attribute [rw] description
  #   A description of why this payload was created and what it is being used for.
  #
  #   @return [String]

  # @!attribute [rw] workspace_id
  #   The ID of the workspace this payload belongs to.
  #
  #   @return [Integer]

  # @!attribute [rw] raw_payload
  #   A URL pointing to where the binary payload can be downloaded from.
  #
  #   @return [String]

  # @!attribute [rw] raw_payload_hash
  #   The unique hash value for the generated payload binary
  #
  #   @return [String]

  # @!attribute [rw] build_opts
  #   A hash containing various options used to build this payload
  #
  #   @return [String]


  #
  # Search Attributes
  #

  search_attribute :uuid,
                   type: :string

  #
  # Serializations
  #

  serialize :urls
  serialize :build_opts

end
