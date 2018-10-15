package com.sp.pay;

import java.util.List;

public class PayOrder {
	private List<Integer> gubunCode;
	private List<Integer> goodsCode;
	private List<String> goodsName;
	private List<Integer> goodsPrice;
	private List<Integer> quantity;
	private List<String> gubunName;
	private List<Integer> parentCode;
	private List<Integer> cartCode;
	private List<String> startDate;
	private List<String> endDate;

	public List<Integer> getGubunCode() {
		return gubunCode;
	}

	public void setGubunCode(List<Integer> gubunCode) {
		this.gubunCode = gubunCode;
	}

	public List<Integer> getGoodsCode() {
		return goodsCode;
	}

	public void setGoodsCode(List<Integer> goodsCode) {
		this.goodsCode = goodsCode;
	}

	public List<String> getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(List<String> goodsName) {
		this.goodsName = goodsName;
	}

	public List<Integer> getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(List<Integer> goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public List<Integer> getQuantity() {
		return quantity;
	}

	public void setQuantity(List<Integer> quantity) {
		this.quantity = quantity;
	}

	public List<String> getGubunName() {
		return gubunName;
	}

	public void setGubunName(List<String> gubunName) {
		this.gubunName = gubunName;
	}

	public List<Integer> getParentCode() {
		return parentCode;
	}

	public void setParentCode(List<Integer> parentCode) {
		this.parentCode = parentCode;
	}

	public List<Integer> getCartCode() {
		return cartCode;
	}

	public void setCartCode(List<Integer> cartCode) {
		this.cartCode = cartCode;
	}

	public List<String> getStartDate() {
		return startDate;
	}

	public void setStartDate(List<String> startDate) {
		this.startDate = startDate;
	}

	public List<String> getEndDate() {
		return endDate;
	}

	public void setEndDate(List<String> endDate) {
		this.endDate = endDate;
	}

}
