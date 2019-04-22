RSpec.describe Sshster::ArgvParser do
  let(:parser) { described_class.new(argv) }
  let(:config_path) { '/home/example/.ssh/sshster.yml' }

  describe '#parse' do
    before { parser.parse }

    context 'command given' do
      let(:argv) { ['compose'] }
      it 'detects command' do
        expect(parser.command).to eq(:compose)
        expect(parser.config).to eq(nil)
      end
    end

    context 'configuration options' do
      let(:argv) { ['-c', config_path, 'init'] }
      it 'detects configuration options' do
        expect(parser.config).to eq(config_path)
        expect(parser.command).to eq(:init)
      end
    end

    context 'configuration options (reverse order)' do
      let(:argv) { ['init', '-c', config_path] }
      it 'detects configuration options' do
        expect(parser.config).to eq(config_path)
        expect(parser.command).to eq(:init)
      end
    end

    context 'command not given' do
      let(:argv) { ['-c', config_path] }
      it 'sets command to nil' do
        expect(parser.config).to eq(config_path)
        expect(parser.command).to eq(nil)
      end
    end
  end

  describe '#valid?' do
    before { parser.parse }

    context 'without command' do
      let(:argv) { ['-c', config_path] }
      it "doesn't accept an empty command" do
        expect(parser.valid?).to eq(false)
      end
    end

    context 'with invalid command' do
      let(:argv) { ['echo'] }
      it 'breaks on invalid command' do
        expect(parser.valid?).to eq(false)
      end
    end

    context 'with valid command' do
      let(:argv) { ['compose'] }
      it 'detects command' do
        expect(parser.valid?).to eq(true)
      end
    end
  end
end
