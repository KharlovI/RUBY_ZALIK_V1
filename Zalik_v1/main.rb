class Publication
  attr_accessor :title, :author, :year, :text

  def initialize(title, author, year, text)
    @title = title
    @author = author
    @year = year
    @text = text
  end

  def to_s
    "#{title} by #{author} (#{year})"
  end
end

class Journal < Publication
  attr_accessor :journal_name

  def initialize(title, author, year, text,  journal_name)
    super(title, author, year, text)
    @journal_name = journal_name
  end
end

class Book < Publication
  attr_accessor :isbn

  def initialize(title, author, year, text, isbn)
    super(title, author, year, text)
    @isbn = isbn
  end
end

class ConferencePaper < Publication
  attr_accessor :conference_name

  def initialize(title, author, year, text, conference_name)
    super(title, author, year, text)
    @conference_name = conference_name
  end
end

class Library
  attr_accessor :publications

  def initialize
    @publications = []
  end

  def add_publication(publication)
    publications << publication
  end

  def find_publication_by_data(title, author, year)
    publications.select do |pub|
      pub.title.include?(title) &&
        pub.author.include?(author) &&
        pub.year.to_s.include?(year.to_s)
    end
  end

  def find_publication_by_keyword(keywords)
    publications.select do |pub|
      keywords.any? { |keyword| pub.title.downcase.include?(keyword.downcase) || pub.author.downcase.include?(keyword.downcase) || pub.text.downcase.include?(keyword.downcase) }
    end
  end

  def sort_by_relevance(query)
    publications.sort_by do |pub|
      relevance_score(pub, query)
    end.reverse
  end

  private

  def relevance_score(publication, query)
    total_relevance = 0
    query.each do |term|
      total_relevance += 1 if publication.title.include?(term) || publication.author.include?(term)
    end
    total_relevance
  end
end