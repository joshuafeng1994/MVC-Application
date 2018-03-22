package neu.edu;

import java.util.List;

import com.google.gson.annotations.SerializedName;

public class ArticleSearch {

//	private String status;
//	private String copyright;
	private Response response;

	public Response getResponse() {
		return response;
	}

	public void setResponse(Response response) {
		this.response = response;
	}
	
	

//	public String getStatus() {
//		return status;
//	}
//
//	public void setStatus(String status) {
//		this.status = status;
//	}

//	public String getCopyright() {
//		return copyright;
//	}
//
//	public void setCopyright(String copyright) {
//		this.copyright = copyright;
//	}



//	public String getCopyright() {
//		return copyright;
//	}
//
//	public void setCopyright(String copyright) {
//		this.copyright = copyright;
//	}

	public class Response{
		private List<DocsDetail> docs;
		private Meta meta;
		public List<DocsDetail> getDocs() {
			return docs;
		}
		public void setDocs(List<DocsDetail> docs) {
			this.docs = docs;
		}
		public Meta getMeta() {
			return meta;
		}
		public void setMeta(Meta meta) {
			this.meta = meta;
		}
		@Override
		public String toString() {
			return "Response [docs=" + docs + ", meta=" + meta + "]";
		}
		
		
	}
	
	public class DocsDetail{
		private String web_url;
		private String snippet;
		private String lead_paragraph;
		
		//abstractContent is abstract in json
		@SerializedName("abstract")
		private String abstractContent;
		private String print_page;
		private Object blog;
		private String source;
		
		private HeadLine headline;
			
		private List<KeyWords> keywords;
			
		private String pub_date;
		private String document_type;
		private String news_desK;
		private String section_name;
		private String subsection_name;
		private ByLine byline;
			
		private String type_of_material;
		private String _id;
		private String word_count;
		private String slideshow_credits;
		
		private List<MultiMedia> multimedia;
		
		
		
		public String getWeb_url() {
			return web_url;
		}

		public void setWeb_url(String web_url) {
			this.web_url = web_url;
		}

		public String getSnippet() {
			return snippet;
		}

		public void setSnippet(String snippet) {
			this.snippet = snippet;
		}

		public String getLead_paragraph() {
			return lead_paragraph;
		}

		public void setLead_paragraph(String lead_paragraph) {
			this.lead_paragraph = lead_paragraph;
		}

		public String getAbstractContent() {
			return abstractContent;
		}

		public void setAbstractContent(String abstractContent) {
			this.abstractContent = abstractContent;
		}

		public String getPrint_page() {
			return print_page;
		}

		public void setPrint_page(String print_page) {
			this.print_page = print_page;
		}

		public Object getBlog() {
			return blog;
		}

		public void setBlog(Object blog) {
			this.blog = blog;
		}

		public String getSource() {
			return source;
		}

		public void setSource(String source) {
			this.source = source;
		}

		public HeadLine getHeadline() {
			return headline;
		}

		public void setHeadline(HeadLine headline) {
			this.headline = headline;
		}

		public List<KeyWords> getKeywords() {
			return keywords;
		}

		public void setKeywords(List<KeyWords> keywords) {
			this.keywords = keywords;
		}

		public String getPub_date() {
			return pub_date;
		}

		public void setPub_date(String pub_date) {
			this.pub_date = pub_date;
		}

		public String getDocument_type() {
			return document_type;
		}

		public void setDocument_type(String document_type) {
			this.document_type = document_type;
		}

		public String getNews_desK() {
			return news_desK;
		}

		public void setNews_desK(String news_desK) {
			this.news_desK = news_desK;
		}

		public String getSection_name() {
			return section_name;
		}

		public void setSection_name(String section_name) {
			this.section_name = section_name;
		}

		public String getSubsection_name() {
			return subsection_name;
		}

		public void setSubsection_name(String subsection_name) {
			this.subsection_name = subsection_name;
		}

		public ByLine getByline() {
			return byline;
		}

		public void setByline(ByLine byline) {
			this.byline = byline;
		}

		public String getType_of_material() {
			return type_of_material;
		}

		public void setType_of_material(String type_of_material) {
			this.type_of_material = type_of_material;
		}

		public String get_id() {
			return _id;
		}

		public void set_id(String _id) {
			this._id = _id;
		}

		public String getWord_count() {
			return word_count;
		}

		public void setWord_count(String word_count) {
			this.word_count = word_count;
		}

		public String getSlideshow_credits() {
			return slideshow_credits;
		}

		public void setSlideshow_credits(String slideshow_credits) {
			this.slideshow_credits = slideshow_credits;
		}

		public List<MultiMedia> getMultimedia() {
			return multimedia;
		}

		public void setMultimedia(List<MultiMedia> multimedia) {
			this.multimedia = multimedia;
		}

		public class HeadLine{
			private String main;
			private String kicker;
			public String getMain() {
				return main;
			}
			public void setMain(String main) {
				this.main = main;
			}
			public String getKicker() {
				return kicker;
			}
			public void setKicker(String kicker) {
				this.kicker = kicker;
			}
			@Override
			public String toString() {
				return "HeadLine [main=" + main + ", kicker=" + kicker + "]";
			}
			
		}
		

		
		public class KeyWords{
			private String rank;
			private String name;
			private String value;
			public String getRank() {
				return rank;
			}
			public void setRank(String rank) {
				this.rank = rank;
			}
			public String getName() {
				return name;
			}
			public void setName(String name) {
				this.name = name;
			}
			public String getValue() {
				return value;
			}
			public void setValue(String value) {
				this.value = value;
			}
			@Override
			public String toString() {
				return "KeyWords [rank=" + rank + ", name=" + name + ", value=" + value + "]";
			}
			
		}
		
		public class ByLine{
			private String organization;
			private String original;
			private List<Person> person;
			public String getOrganization() {
				return organization;
			}
			public void setOrganization(String organization) {
				this.organization = organization;
			}
			public String getOriginal() {
				return original;
			}
			public void setOriginal(String original) {
				this.original = original;
			}	
			public List<Person> getPerson() {
				return person;
			}
			public void setPerson(List<Person> person) {
				this.person = person;
			}


			public class Person{
				private String firstname;
				private String middlename;
				private String lastname;
				private String qualifier;
				private String title;
				private String role;
				private String organization;
				private Integer rank;
				public String getFirstname() {
					return firstname;
				}
				public void setFirstname(String firstname) {
					this.firstname = firstname;
				}
				public String getMiddlename() {
					return middlename;
				}
				public void setMiddlename(String middlename) {
					this.middlename = middlename;
				}
				public String getLastname() {
					return lastname;
				}
				public void setLastname(String lastname) {
					this.lastname = lastname;
				}
				public String getQualifier() {
					return qualifier;
				}
				public void setQualifier(String qualifier) {
					this.qualifier = qualifier;
				}
				public String getTitle() {
					return title;
				}
				public void setTitle(String title) {
					this.title = title;
				}
				public String getRole() {
					return role;
				}
				public void setRole(String role) {
					this.role = role;
				}
				public String getOrganization() {
					return organization;
				}
				public void setOrganization(String organization) {
					this.organization = organization;
				}
				public Integer getRank() {
					return rank;
				}
				public void setRank(Integer rank) {
					this.rank = rank;
				}
				@Override
				public String toString() {
					return "Person [firstname=" + firstname + ", middlename=" + middlename + ", lastname=" + lastname
							+ ", qualifier=" + qualifier + ", title=" + title + ", role=" + role + ", organization="
							+ organization + ", rank=" + rank + "]";
				}
				
				
				
			}


			@Override
			public String toString() {
				return "ByLine [organization=" + organization + ", original=" + original + ", person=" + person + "]";
			}
			

		}

		public class MultiMedia{
			private String url;
			private String format;
			private Integer height;
			private Integer width;
			private String type;
			private String subtype;
			private String caption;
			private String copyright;
			public String getUrl() {
				return url;
			}
			public void setUrl(String url) {
				this.url = url;
			}
			public String getFormat() {
				return format;
			}
			public void setFormat(String format) {
				this.format = format;
			}
			public Integer getHeight() {
				return height;
			}
			public void setHeight(Integer height) {
				this.height = height;
			}
			public Integer getWidth() {
				return width;
			}
			public void setWidth(Integer width) {
				this.width = width;
			}
			public String getType() {
				return type;
			}
			public void setType(String type) {
				this.type = type;
			}
			public String getSubtype() {
				return subtype;
			}
			public void setSubtype(String subtype) {
				this.subtype = subtype;
			}
			public String getCaption() {
				return caption;
			}
			public void setCaption(String caption) {
				this.caption = caption;
			}
			public String getCopyright() {
				return copyright;
			}
			public void setCopyright(String copyright) {
				this.copyright = copyright;
			}
			@Override
			public String toString() {
				return "MultiMedia [url=" + url + ", format=" + format + ", height=" + height + ", width=" + width
						+ ", type=" + type + ", subtype=" + subtype + ", caption=" + caption + ", copyright="
						+ copyright + "]";
			}
			
			
			
			}

		@Override
		public String toString() {
			return "DocsDetail [web_url=" + web_url + ", snippet=" + snippet + ", lead_paragraph=" + lead_paragraph
					+ ", abstractContent=" + abstractContent + ", print_page=" + print_page + ", blog=" + blog
					+ ", source=" + source + ", headline=" + headline + ", keywords=" + keywords + ", pub_date="
					+ pub_date + ", document_type=" + document_type + ", news_desK=" + news_desK + ", section_name="
					+ section_name + ", subsection_name=" + subsection_name + ", byline=" + byline
					+ ", type_of_material=" + type_of_material + ", _id=" + _id + ", word_count=" + word_count
					+ ", slideshow_credits=" + slideshow_credits + ", multimedia=" + multimedia + "]";
		}
			
			
			
		}
	
	public class Meta{
		private Integer hits;
		private Integer time;
		private Integer offset;
		public Integer getHits() {
			return hits;
		}
		public void setHits(Integer hits) {
			this.hits = hits;
		}
		public Integer getTime() {
			return time;
		}
		public void setTime(Integer time) {
			this.time = time;
		}
		public Integer getOffset() {
			return offset;
		}
		public void setOffset(Integer offset) {
			this.offset = offset;
		}
		@Override
		public String toString() {
			return "Meta [hits=" + hits + ", time=" + time + ", offset=" + offset + "]";
		}
		
		
	}

	@Override
	public String toString() {
		return "ArticleSearch [response=" + response + "]";
	}	
	
			
	}
	


		

		
	
	


