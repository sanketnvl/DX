package com.myexample.model;

public class DocumentCount {

	private int total;
	private int complete;
	private int uncomplete;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getComplete() {
		return complete;
	}
	public void setComplete(int complete) {
		this.complete = complete;
	}
	public int getUncomplete() {
		return uncomplete;
	}
	public void setUncomplete(int uncomplete) {
		this.uncomplete = uncomplete;
	}
	@Override
	public String toString() {
		return "DocumentCount [total=" + total + ", complete=" + complete
				+ ", uncomplete=" + uncomplete + "]";
	}
	
	
	
}
