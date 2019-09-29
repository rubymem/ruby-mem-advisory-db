load File.join(File.dirname(__FILE__), 'spec_helper.rb')
require 'yaml'

shared_examples_for 'Advisory' do |path|
  advisory = YAML.load_file(path)

  describe path do
    let(:filename) { File.basename(path) }

    it "should be correctly named CVE-XXX or OSVDB-XXX" do
      expect(filename).
        to match(/^(CVE-\d{4}-(0\d{3}|[1-9]\d{3,})|OSVDB-\d+)\.yml$/)
    end

    describe "framework" do
      subject { advisory['framework'] }

      it "may be nil or a String" do
        expect(subject).to be_kind_of(String).or(be_nil)
      end
    end

    describe "platform" do
      subject { advisory['platform'] }

      it "may be nil or a String" do
        expect(subject).to be_kind_of(String).or(be_nil)
      end
    end


    describe "url" do
      subject { advisory['url'] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "title" do
      subject { advisory['title'] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "date" do
      subject { advisory['date'] }

      it { is_expected.to be_kind_of(Date) }
    end

    describe "description" do
      subject { advisory['description'] }

      it { is_expected.to be_kind_of(String) }
      it { is_expected.not_to be_empty }
    end

    describe "patched_versions" do
      subject { advisory['patched_versions'] }

      it "may be nil or an Array" do
        expect(subject).to be_kind_of(Array).or(be_nil)
      end

      describe "each patched version" do
        if advisory['patched_versions']
          advisory['patched_versions'].each do |version|
            describe version do
              subject { version.split(', ') }

              it "should contain valid RubyGem version requirements" do
                expect {
                Gem::Requirement.new(*subject)
                }.not_to raise_error
              end
            end
          end
        end
      end
    end

    describe "unaffected_versions" do
      subject { advisory['unaffected_versions'] }

      it "may be nil or an Array" do
        expect(subject).to be_kind_of(Array).or(be_nil)
      end

      case advisory['unaffected_versions']
      when Array
        advisory['unaffected_versions'].each do |version|
          describe version do
            subject { version.split(', ') }

            it "should contain valid RubyGem version requirements" do
              expect {
                Gem::Requirement.new(*subject)
              }.not_to raise_error
            end
          end
        end
      end
    end

    describe "related" do
      subject { advisory['related'] }

      it "may be nil or a Hash" do
        expect(subject).to be_kind_of(Hash).or(be_nil)
      end

      case advisory["related"]
      when Hash
        advisory["related"].each_pair do |name, values|
          describe name do
            it "should be either a cve, an osvdb or a url" do
              expect(["cve", "osvdb", "url"]).to include(name)
            end

            it "should always contain an array" do
              expect(values).to be_kind_of(Array)
            end
          end
        end
      end
    end


  end
end
