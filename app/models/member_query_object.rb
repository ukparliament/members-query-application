class MemberQueryObject
  extend QueryObject

  def self.all
    result = self.query('
			PREFIX parl: <http://data.parliament.uk/schema/parl#>
			PREFIX schema: <http://schema.org/>
			CONSTRUCT {
				?person
					schema:name ?name .
			}
			WHERE {
				?person
					a schema:Person ;
					schema:name ?name .
			}')

    people = self.single_statement_mapper(graph, Schema.name, :name)

    hierarchy = {
        people: people
    }

    { graph: result, hierarchy: hierarchy }
  end

  def self.find(uri)
    result = self.query("
				PREFIX schema: <http://schema.org/>
				PREFIX parl: <http://data.parliament.uk/schema/parl#>
				PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
				CONSTRUCT {
					<#{uri}>
				   		schema:name ?name ;
						  parl:house ?house ;
				    	parl:oralQuestionCount ?oralQuestionCount ;
				   		parl:writtenQuestionCount ?writtenQuestionCount ;
				    	parl:membershipCount ?membershipCount ;
			      	parl:writtenAnswerCount ?writtenAnswerCount ;
		        	parl:voteCount ?voteCount ;
		        	parl:orderPaperItemCount ?orderPaperItemsCount ;
						  parl:constituency ?constituency ;
						  parl:constituencyLabel ?constituencyLabel .
					?house
						rdfs:label ?label .
				}
				WHERE {
				    SELECT ?name ?house ?label ?constituency ?constituencyLabel (COUNT(DISTINCT ?oralQuestion) AS ?oralQuestionCount) (COUNT(DISTINCT ?writtenQuestion) AS ?writtenQuestionCount) (COUNT(DISTINCT ?writtenAnswer) as ?writtenAnswerCount) (COUNT(DISTINCT ?vote) as ?voteCount) (COUNT(?membership) AS ?membershipCount) (COUNT(?orderPaperItem) AS ?orderPaperItemsCount)
				    WHERE {
				     	?person
							schema:name ?name ;
							parl:house ?house .
						?house
							rdfs:label ?label .
						OPTIONAL {
							?constituency
								parl:member ?person ;
								a parl:Constituency ;
								rdfs:label ?constituencyLabel .
							}
			        	{
			        		?oralQuestion
			        			a parl:OralParliamentaryQuestion ;
			        			parl:member ?person .
			        	}
			        	UNION {
			        	    ?writtenQuestion
			        	        a parl:WrittenParliamentaryQuestion ;
			        	        parl:member ?person .
			        	}
			        	UNION {
			        	    ?writtenAnswer
			        	        a parl:WrittenParliamentaryAnswer ;
			        	        parl:member ?person .
			        	}
			        	UNION {
            				?orderPaperItem
                				a parl:OrderPaperItem ;
                				parl:member ?person .
        				}
			        	UNION {
			        	    ?vote
			      				parl:member ?person ;
			      				parl:division ?division .
			        	}
			        	UNION {
			        	    ?membership
			        	        parl:member ?person ;
			        	        a ?committeeParticipation .
			        	    FILTER (?committeeParticipation = parl:CommitteeMember || ?committeeParticipation = parl:CommitteeChair || ?committeeParticipation = parl:CommitteeAdviser)
			        	}
			    		FILTER(?person = <#{uri}>)
			    	}
			    GROUP BY ?name ?house ?label ?constituency ?constituencyLabel
			}")

    #carry on with this tomorrow
    person_uri = RDF::URI.new(uri)
    person = self.single_statement_mapper(graph, Schema.name, :name)
    person[:house] = self.single_statement_mapper(graph, Rdfs.label, :label)
    person[:constituency] = self.single_statement_mapper(graph, Parl.constituencyLabel, :label)

    subject_uri = RDF::URI.new(uri)
    name = self.get_object(result, subject_uri, Schema.name).to_s
    house = self.get_object(result, subject_uri, Parl.house)
    label = self.get_object(result, house, Rdfs.label).to_s
    constituency = self.get_object(result, subject_uri, Parl.constituency)
    constituency_label = self.get_object(result, constituency, Parl.constituencyLabel).to_s

    oral_question_count = self.get_object(result, subject_uri, Parl.oralQuestionCount).to_i
    written_question_count = self.get_object(result, subject_uri, Parl.writtenQuestionCount).to_i
    written_answer_count = self.get_object(result, subject_uri, Parl.writtenAnswerCount).to_i
    vote_count = self.get_object(result, subject_uri, Parl.voteCount).to_i
    membership_count = self.get_object(result, subject_uri, Parl.membershipCount).to_i
    order_paper_item_count = self.get_object(result, subject_uri, Parl.orderPaperItemCount).to_i

    hierarchy =
        {
            :id => self.get_id(uri),
            :name => name,
            :house => {
                :id => self.get_id(house),
                :label => label
            },
            :constituency => {
                :id => self.get_id(constituency),
                :label => constituency_label
            },
            :oral_question_count => oral_question_count,
            :written_question_count => written_question_count,
            :written_answer_count => written_answer_count,
            :vote_count => vote_count,
            :membership_count => membership_count,
            :order_paper_item_count => order_paper_item_count
        }

    { :graph => result, :hierarchy => hierarchy }

  end
end