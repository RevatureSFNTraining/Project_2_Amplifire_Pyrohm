public class JSON2ApexWeather {

	public class Condition {
		public String text {get;set;} 
		public String icon {get;set;} 

		public Condition(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'text') {
							text = parser.getText();
						} else if (text == 'icon') {
							icon = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Condition consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Location location {get;set;} 
	public Current current {get;set;} 

	public JSON2ApexWeather(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'location') {
						location = new Location(parser);
					} else if (text == 'current') {
						current = new Current(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2ApexWeather consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Current {
		public Integer last_updated_epoch {get;set;} 
		public String last_updated {get;set;} 
		public Integer is_day {get;set;} 
		public Condition condition {get;set;} 
		public Double precip_mm {get;set;} 
		public Double precip_in {get;set;} 
		public Integer humidity {get;set;} 
		public Integer cloud {get;set;} 
		public Double uv {get;set;} 

		public Current(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'last_updated_epoch') {
							last_updated_epoch = parser.getIntegerValue();
						} else if (text == 'last_updated') {
							last_updated = parser.getText();
						} else if (text == 'is_day') {
							is_day = parser.getIntegerValue();
						} else if (text == 'condition') {
							condition = new Condition(parser);
						} else if (text == 'precip_mm') {
							precip_mm = parser.getDoubleValue();
						} else if (text == 'precip_in') {
							precip_in = parser.getDoubleValue();
						} else if (text == 'humidity') {
							humidity = parser.getIntegerValue();
						} else if (text == 'cloud') {
							cloud = parser.getIntegerValue();
						} else if (text == 'uv') {
							uv = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Current consuming unrecognized property: '+text);
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
	
	
	public static JSON2ApexWeather parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2ApexWeather(parser);
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