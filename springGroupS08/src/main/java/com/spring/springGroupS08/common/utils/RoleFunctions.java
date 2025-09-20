package com.spring.springGroupS08.common.utils;

import java.util.List;

import com.spring.springGroupS08.common.enums.RoleType;

public class RoleFunctions {
	// JSP에서 호출 할 함수
	public static String getTopRoleName(List<String> roles) {
		return RoleType.getTopRoleName(roles);
	}
}
