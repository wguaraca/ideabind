require 'spec_helper'

describe Comment do
	describe "should respond to" do
		sym_arr = %i(id usr_id content upd_id com_id
			created_at)
		sym_arr.each { |sym| it { should respond_to sym } }
	end


end