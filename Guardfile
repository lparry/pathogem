# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard('rspec',  :version => 2,
                :cli => "--color --format nested",
                :all_after_pass => true,
                :all_on_start => true) do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
end
