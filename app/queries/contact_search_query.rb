class ContactSearchQuery
  def initialize(relation = Contact.all)
    @relation = relation
  end

  def search(query)
    if query.present?
      @relation = @relation.where("name ILIKE ?", "%#{query}%")
                           .or(@relation.where(cpf: query))
    end
    @relation
  end
end
