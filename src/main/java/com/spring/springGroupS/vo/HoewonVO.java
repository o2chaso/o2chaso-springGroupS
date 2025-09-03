package com.spring.springGroupS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
/*
	@AllArgsConstructor
	@NoArgsConstructor
	@Data
	@Builder
 */
public class HoewonVO {
	private String mid;
	private String pwd;
	private String name;
	private String gender;
	private int age;
	
	private String nickName;
	private String strGender;
}
