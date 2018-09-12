package util;

public class Pagination {
	private int ye;
	private int maxYe;
	private int begin;
	private int beginYe;
	private int endYe;
	private int count;

	// numInPage：一页中表格显示多少条记录
	// numOfPage：一页中显示几个页码
	public Pagination(int ye, int count, int numInPage, int numOfPage) {
		if (ye < 1) {
			ye = 1;
		}
		begin = (ye - 1) * numInPage;
		maxYe = count % numInPage == 0 ? count / numInPage : count / numInPage + 1;
		if (ye > maxYe) {
			ye = maxYe;
		}
		if (maxYe > numOfPage) {
			if (ye <= numOfPage / 2 + 1) {
				beginYe = 1;
				endYe = numOfPage;
			} else if (ye > maxYe - numOfPage / 2) {
				beginYe = maxYe-numOfPage+1;
				endYe = maxYe;
			} else {
				beginYe = ye - numOfPage / 2;
				endYe = ye - numOfPage / 2 + numOfPage-1;
			}

		} else {
			beginYe = 1;
			endYe = maxYe;
		}

		this.ye = ye;
	}

	public int getYe() {
		return ye;
	}

	public int getMaxYe() {
		return maxYe;
	}

	public int getBeginYe() {
		return beginYe;
	}

	public int getEndYe() {
		return endYe;
	}

	public int getCount() {
		return count;
	}

	public int getBegin() {
		return begin;
	}

}
