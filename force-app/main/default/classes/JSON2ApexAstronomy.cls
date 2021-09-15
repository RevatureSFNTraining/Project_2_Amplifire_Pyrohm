public class JSON2ApexAstronomy {

	public Location location {get;set;} 
	public Astronomy astronomy {get;set;} 

	public JSON2ApexAstronomy(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'location') {
						location = new Location(parser);
					} else if (text == 'astronomy') {
						astronomy = new Astronomy(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Astro {
		public String sunrise {get;set;} 
		public String sunset {get;set;} 
		public String moonrise {get;set;} 
		public String moonset {get;set;} 
		public String moon_phase {get;set;} 
		public String moon_illumination {get;set;} 

		public Astro(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'sunrise') {
							sunrise = parser.getText();
						} else if (text == 'sunset') {
							sunset = parser.getText();
						} else if (text == 'moonrise') {
							moonrise = parser.getText();
						} else if (text == 'moonset') {
							moonset = parser.getText();
						} else if (text == 'moon_phase') {
							moon_phase = parser.getText();
						} else if (text == 'moon_illumination') {
							moon_illumination = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Astro consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Astronomy {
		public Astro astro {get;set;} 

		public Astronomy(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'astro') {
							astro = new Astro(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Astronomy consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Location {
		public String name {get;set;} 
		public String region {get;set;} 
		public String country {get;set;} 
		public Double lat {get;set;} 
		public Double lon {get;set;} 
		public String tz_id {get;set;} 
		public Integer localtime_epoch {get;set;} 
		public String localtime {get;set;} 

		public Location(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'region') {
							region = parser.getText();
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else if (text == 'lon') {
							lon = parser.getDoubleValue();
						} else if (text == 'tz_id') {
							tz_id = parser.getText();
						} else if (text == 'localtime_epoch') {
							localtime_epoch = parser.getIntegerValue();
						} else if (text == 'localtime') {
							localtime = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Location consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2ApexAstronomy parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2ApexAstronomy(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
}