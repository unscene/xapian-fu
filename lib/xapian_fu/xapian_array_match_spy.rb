class XapianFu::ArrayCountMatchSpy < Xapian::ValueCountMatchSpy	
	def values()		
		values = []	
	  	Xapian._safelyIterate(self._dangerous_values_begin(), self._dangerous_values_end()) do |item|
		  	terms = YAML::load(item.term)
		  	terms ||= []
		  	terms.each do |term|
		  		idx = values.find_index { |val| val.term == term }				
				values[idx].termfreq += 1 if idx 
		    	values << Xapian::Term.new(term, 0, item.termfreq) unless idx
		    end		    
	  	end
	  	values
	end
	
	def top_values(maxvalues)
		values = []
	  	Xapian._safelyIterate(self._dangerous_top_values_begin(maxvalues), self._dangerous_top_values_end(maxvalues)) do |item|		  	
		  	terms = YAML::load(item.term)
		  	terms ||= []
		  	terms.each do |term|
		  		idx = values.find_index { |val| val.term == term }				
				values[idx].termfreq += 1 if idx 
		    	values << Xapian::Term.new(term, 0, item.termfreq) unless idx
		    end	   
	  	end
	  	values
	end 
end