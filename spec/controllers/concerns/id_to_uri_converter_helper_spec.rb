require 'rails_helper'

describe IdToUriConverterHelper do
  let(:extended_class) { Class.new { extend IdToUriConverterHelper } }

  describe '#convert_id_to_resource_uri' do
    it 'should take an id and convert it to a uri for the endpoint' do
      expect(extended_class.convert_id_to_resource_uri('1')).to eq 'http://id.ukpds.org/1'
    end
  end
end