# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Copyright (c) 2009 Perry Smith

# This file is part of activerecord_constraints.

# activerecord_constraints is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# activerecord_constraints is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with activerecord_constraints.  If not, see
# <http://www.gnu.org/licenses/>.

require 'activerecord_constraints'
require 'activerecord_constraint_handlers'

ActiveRecord::Base.schema_format = :sql

module ::ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      def disable_referential_integrity(&block)
        transaction {
          begin
            execute "SET CONSTRAINTS ALL DEFERRED"
            yield
          ensure
            execute "SET CONSTRAINTS ALL IMMEDIATE"
          end
        }
      end
    end
  end
end
