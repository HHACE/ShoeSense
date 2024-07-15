<nav>
                <ul class="listcontent">
                    <li>
                        <a href="/ShoeSense/admin/finance"><i class="fa fa-home me-3"></i> 
                            <span>Finance</span>
                        </a>
                    </li>
                 
                                        <li>
                        <a href="/ShoeSense/product/manage?type='view'"><i class="fa fa-product-hunt me-3"></i> 
                            <span>Product</span>
                        </a>
                    </li>
                    <li>
                        <a href="/ShoeSense/import/manage"
                           ><i class="fa fa-download me-3"></i>
                            <span>Import</span>
                        </a>
                    </li>
                    <li>
                        <a href="/ShoeSense/order/manage"
                           ><i class="fa fa-file me-3"></i>
                            <span>Orders</span>
                        </a>
                    </li>
                    
                                        <li>
                            <a href="/ShoeSense/user/profile/<%=session.getAttribute("id")%>"
                           ><i class="fa fa-file me-3"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    
                    <li>
                        <a href="/ShoeSense/logout"><i class="fa fa-sign-out me-3"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>