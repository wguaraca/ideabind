require 'spec_helper'

describe Comment do
	sym_arr = %i(user_id, content, update, parent_comment,
		child_comment, created_at)
	sym_arr.each { |sym| it { should respond_to sym } }
	

end