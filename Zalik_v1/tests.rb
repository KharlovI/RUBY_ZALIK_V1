require 'test/unit'
require_relative 'main.rb'
class TestLibrary < Test::Unit::TestCase
  def setup
    @library = Library.new

    @journal = Journal.new("Article 1", "John Doe", 2020, "Sample content", "Journal of Science")
    @book = Book.new("Book 1", "Jane Smith", 2018, "Book content", "1234567890")
    @conference_paper = ConferencePaper.new("Paper 1", "Emily Brown", 2021, "Conference paper content", "International Conference on Computer Science")

    @library.add_publication(@journal)
    @library.add_publication(@book)
    @library.add_publication(@conference_paper)
  end

  def test_search_by_bibliographic_data
    result = @library.find_publication_by_data("Article 1", "John Doe", 2020)
    assert_equal([@journal], result)
  end

  def test_search_by_keyword
    result = @library.find_publication_by_keyword(["Sample", "content"])
    assert_equal([@journal, @book, @conference_paper], result)
  end

  def test_sort_by_relevance
    result = @library.sort_by_relevance(["Article", "John"])
    assert_equal([@journal, @conference_paper, @book], result)
  end

  # В цьому кейсі бібліотека вже непорожня,
  # тож я додав до поля текст число 5, яке
  # не зустрічається в інших публікаціях
  def test_add_and_search_conference_paper

    new_conference_paper = ConferencePaper.new("New Paper", "Jack Johnson", 2022, "5", "International Conference on Technology")
    @library.add_publication(new_conference_paper)
    result = @library.find_publication_by_keyword(["5"])
    assert_equal [new_conference_paper], result
  end
end